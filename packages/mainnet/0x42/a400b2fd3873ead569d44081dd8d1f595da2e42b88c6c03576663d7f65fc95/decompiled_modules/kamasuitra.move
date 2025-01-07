module 0x42a400b2fd3873ead569d44081dd8d1f595da2e42b88c6c03576663d7f65fc95::kamasuitra {
    struct KAMASUITRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAMASUITRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAMASUITRA>(arg0, 6, b"KamaSUItra", b"KAMASUITRA", x"546865204b616d61737574726120697320746865206f6c6465737420657874616e7420496e6469616e20736369656e7469666963207472656174697365206f6e20746865207375626a656374206f6620706c656173756972652e0a5768617420697320796f7572206661766f7269746520706f736974696f6e3f2036393f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kamasutra_ad48bb2e93.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAMASUITRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAMASUITRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

