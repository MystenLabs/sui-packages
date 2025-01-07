module 0x9ab057f93c5fef54ef94b9e1181442383c76bfc9281f551ae2479c712fb1dd1::erh {
    struct ERH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERH>(arg0, 9, b"ERH", b"Earth ", b"Beautiful Earth In Future Create A Biggest Ec-osystem In Galaxy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/67bc4d95-43b7-4d4e-9839-2aaa90c39893.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ERH>>(v1);
    }

    // decompiled from Move bytecode v6
}

