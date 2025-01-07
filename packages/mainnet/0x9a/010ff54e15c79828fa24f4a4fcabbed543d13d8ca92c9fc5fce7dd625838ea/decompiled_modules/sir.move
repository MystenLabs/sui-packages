module 0x9a010ff54e15c79828fa24f4a4fcabbed543d13d8ca92c9fc5fce7dd625838ea::sir {
    struct SIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIR>(arg0, 6, b"SIR", b"Sir_x1000", x"4920616d206c617a7920616e6420726963680a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_02_10_18_04_49_2_removebg_preview_0904c71b64.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIR>>(v1);
    }

    // decompiled from Move bytecode v6
}

