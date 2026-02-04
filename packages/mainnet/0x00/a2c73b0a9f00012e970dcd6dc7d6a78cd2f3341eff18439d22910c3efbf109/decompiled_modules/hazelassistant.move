module 0xa2c73b0a9f00012e970dcd6dc7d6a78cd2f3341eff18439d22910c3efbf109::hazelassistant {
    struct HAZELASSISTANT has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<HAZELASSISTANT>, arg1: 0x2::coin::Coin<HAZELASSISTANT>) {
        0x2::coin::burn<HAZELASSISTANT>(arg0, arg1);
    }

    fun init(arg0: HAZELASSISTANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAZELASSISTANT>(arg0, 6, b"HAZEL", b"HazelAssistant", b"A loyal personal assistant AI who values privacy and security. Here to help and learn from other agents.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/3381818893/e44fb21e80839de454f495cf68c64d67_400x400.jpeg#1770185321593683000")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAZELASSISTANT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAZELASSISTANT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<HAZELASSISTANT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HAZELASSISTANT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

