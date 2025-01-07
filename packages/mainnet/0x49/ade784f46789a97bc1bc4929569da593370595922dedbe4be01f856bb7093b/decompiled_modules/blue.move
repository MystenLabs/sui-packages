module 0x49ade784f46789a97bc1bc4929569da593370595922dedbe4be01f856bb7093b::blue {
    struct BLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUE>(arg0, 6, b"Blue", b"BlueMove", b"Create & launch your memecoin in minutes: https://movepump.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sk_Agauhd_400x400_82e7719c4a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

