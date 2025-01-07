module 0x39de73e7c35abcaba3d883d87566a7959c0b7e906542cffd0c68361c5049028d::toc {
    struct TOC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOC>(arg0, 6, b"TOC", b"Terminal Of Chat", b"Terminal of Chats tracks over 1000+ crypto telegram groups and channels to provide to you the most relevant information.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7h_Nu_Tcoy_400x400_b65fad2723.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOC>>(v1);
    }

    // decompiled from Move bytecode v6
}

