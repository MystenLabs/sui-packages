module 0xd747d7efde3d6945c5429aeb7758fb9d9b2cae64d577355a222ed630fb953b67::dd {
    struct DD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DD>(arg0, 6, b"DD", b"DiversDown", b"is the official token of DiversDown, a fun and community-driven meme coin built on the Sui blockchain. It represents more than just a digital asset, it's a symbol of adventure, excitement, and shared experiences within our growing community. Whether you're collecting, trading, or diving into our treasure hunts, DD Coin adds value to every interaction, making cryptocurrency enjoyable and accessible to all.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/piclumen_1728740182237_c91d1339ff.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DD>>(v1);
    }

    // decompiled from Move bytecode v6
}

