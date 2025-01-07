module 0x5e7e93711e370dccb0d6aeb5ae5b1eac67fbab212ab64eb41361a45aa853254a::vmt {
    struct VMT has drop {
        dummy_field: bool,
    }

    fun init(arg0: VMT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VMT>(arg0, 9, b"VMT", b"Voldemort", b"Dont Say His Name And Buyy His Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8a6af9db-df0b-4f3a-b6bc-f0eff2def938.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VMT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VMT>>(v1);
    }

    // decompiled from Move bytecode v6
}

