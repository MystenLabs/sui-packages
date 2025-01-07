module 0xf96b367f6fe9256f07464864b3f2935a49501d63a5676b83e550b60ff0dd87b0::goatfy {
    struct GOATFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOATFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOATFY>(arg0, 6, b"GoatFY", b"GoatForYou", x"4e6f2070726f6d697365732c206e6f206d61726b6574696e672c206e6f20666c75666624476f61744659206973206a75737420666f7220796f75210a5765277265207374617274696e672066726f6d207a65726f2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Desain_tanpa_judul_4_657e57b867.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOATFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOATFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

