module 0xc2af025b5fd5281df84bd17282ea856ee5a9d6774a7b53a2fdd2a523e1c91d39::aac {
    struct AAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAC>(arg0, 9, b"AAC", b"any account create", b"AAC coin is a cryptocurrency designed to reward individuals who take action and achieve real-world results. In a world filled with passive participation, Its core belief f simple: \"actions speak louder than words My coin best next here...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/9a63ca4acf42cabf14cb71f6a9d81cddblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

