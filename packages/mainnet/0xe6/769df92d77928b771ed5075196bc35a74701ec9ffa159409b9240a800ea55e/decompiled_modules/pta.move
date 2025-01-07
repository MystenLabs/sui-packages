module 0xe6769df92d77928b771ed5075196bc35a74701ec9ffa159409b9240a800ea55e::pta {
    struct PTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTA>(arg0, 9, b"PTA", b"Puttotalk", b"Put to talk or silen to die", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/448c1057-1566-4aa1-ad06-0965b171890c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

