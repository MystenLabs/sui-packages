module 0x36df6f041a4b7626f6734c5aeca6b1796e99e722ddcb3afee1a608fb90c20ef2::of {
    struct OF has drop {
        dummy_field: bool,
    }

    fun init(arg0: OF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OF>(arg0, 6, b"OF", b"OnlyFrens", x"57652077696c6c2062652074686520696e666c75656e63657273206f662074686520696e666c75656e63657273202d2050616d7020697420283b0a4e6565642068656c702073657474696e672075702074656c656772616d20616e642077656273697465204170706c65206c6f636b6564206d65206f7574206f66206d792061636374", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0094_e260b7b195.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OF>>(v1);
    }

    // decompiled from Move bytecode v6
}

