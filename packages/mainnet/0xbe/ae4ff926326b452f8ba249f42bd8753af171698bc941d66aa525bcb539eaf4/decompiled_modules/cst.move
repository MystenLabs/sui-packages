module 0xbeae4ff926326b452f8ba249f42bd8753af171698bc941d66aa525bcb539eaf4::cst {
    struct CST has drop {
        dummy_field: bool,
    }

    fun init(arg0: CST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CST>(arg0, 9, b"CST", b"Carsst ", b"CatRest", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9a137b5a-9c76-4a0b-b311-fb9041df9f7a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CST>>(v1);
    }

    // decompiled from Move bytecode v6
}

