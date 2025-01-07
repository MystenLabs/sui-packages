module 0xa090fba4c0661bfff09d6ac05831203b0baaa94ccbc81e7bbdf3e56ba8d69c69::smurfsuicr7 {
    struct SMURFSUICR7 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMURFSUICR7, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMURFSUICR7>(arg0, 6, b"SMURFSUICR7", b"SMURF7SUI7", b"CRISRONALDO7SMURF7", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_12_022308107_4e807be452.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMURFSUICR7>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMURFSUICR7>>(v1);
    }

    // decompiled from Move bytecode v6
}

