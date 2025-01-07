module 0xd63d288a147cee62a5c43ce3f035e8145e747dcfdc510ba54b64139d637852fe::suimuskk {
    struct SUIMUSKK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMUSKK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMUSKK>(arg0, 6, b"SUIMUSKK", b"SUIMUSK", b"SuiMusk is a forward-looking cryptocurrency that combines the innovative power of blockchain technology with the visionary approach of Elon Musk. Merging the speed and security of the Sui infrastructure with Musks revolutionary influence in tech, this token is designed for use in decentralized finance and next-generation technology projects. SuiMusk offers a blend of speed, security, and innovation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/resim_2024_09_17_004316953_279061fcc1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMUSKK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMUSKK>>(v1);
    }

    // decompiled from Move bytecode v6
}

