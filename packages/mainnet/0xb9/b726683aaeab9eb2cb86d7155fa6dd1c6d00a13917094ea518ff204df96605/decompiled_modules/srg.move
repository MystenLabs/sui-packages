module 0xb9b726683aaeab9eb2cb86d7155fa6dd1c6d00a13917094ea518ff204df96605::srg {
    struct SRG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRG>(arg0, 6, b"SRG", b"SUIRUG", b"THE ONLY RUG ALLOWED ! PURE MEME NO FADE NO PAPERHANDS RUN IT ALL THE WAY COMMUNITY WISE! LETS FRONTRUN TO MILLIONS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_7ebe9918bf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRG>>(v1);
    }

    // decompiled from Move bytecode v6
}

