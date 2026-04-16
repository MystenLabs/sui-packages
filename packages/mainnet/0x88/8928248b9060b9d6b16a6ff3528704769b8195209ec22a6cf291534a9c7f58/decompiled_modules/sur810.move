module 0x888928248b9060b9d6b16a6ff3528704769b8195209ec22a6cf291534a9c7f58::sur810 {
    struct SUR810 has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUR810>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUR810>>(0x2::coin::mint<SUR810>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SUR810, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUR810>(arg0, 9, b"SUR810", b"SUR Credit", x"5355522043726564697420746f6b656e20e28094204669626f6e6163636920737570706c793a20363736352e20496e737572616e63653a203130306270732e2058616861753a20724a41584c7a7369507a504d575936465a4d68516a356577415933556d565634727a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://zedec.io/tokens/sur810.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUR810>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUR810>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

