module 0xffcd7881a9bfaf6da225927a242fb61acd7f1cabe8611e62df31c5007971305e::pungy {
    struct PUNGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUNGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUNGY>(arg0, 9, b"PUNGY", b"PungyPop", b"PungyPop is a fun, penguin-themed token for playful, community-driven projects in the crypto space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1445734445940502530/vKURugQZ.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUNGY>(&mut v2, 22000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUNGY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUNGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

