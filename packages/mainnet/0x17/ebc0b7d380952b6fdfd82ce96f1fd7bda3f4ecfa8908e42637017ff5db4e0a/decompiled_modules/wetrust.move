module 0x17ebc0b7d380952b6fdfd82ce96f1fd7bda3f4ecfa8908e42637017ff5db4e0a::wetrust {
    struct WETRUST has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<WETRUST>, arg1: 0x2::coin::Coin<WETRUST>) {
        0x2::coin::burn<WETRUST>(arg0, arg1);
    }

    fun init(arg0: WETRUST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WETRUST>(arg0, 6, b"WETRUST", b"WeTrust", b"WETRUST is a community-driven crypto token focused on trust, transparency, and decentralized collaboration.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://mogra-prod.sgp1.digitaloceanspaces.com/mogra/llm/images/1770682679370-bbf40748.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WETRUST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WETRUST>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<WETRUST>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WETRUST>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

