module 0xad7e4bacdda6a0fc3fddeb03314871f9dd3b77b8013f9c48e3326e444e7690db::mlb {
    struct MLB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MLB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MLB>(arg0, 9, b"MLB", b" MEMES LAB", b"Best meme lab on TON!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d177215a-3b98-4c69-a77d-5ad7b1abf125.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MLB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MLB>>(v1);
    }

    // decompiled from Move bytecode v6
}

