module 0x9fa84123b292fb479c183e3a7dd66740d14123ba316ba570c9ff6814801c20db::wga {
    struct WGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WGA>(arg0, 6, b"WGA", b"WeedGrowingAlliance", x"5765656447726f77696e67416c6c69616e63652e0a446f20796f75206c696b652077656564206966207965732073746179206f66206e6f74206c65617665207468616e6b20796f750a616c6f74206f6620776f726b20697320696e2070726f67726573732e20737461792074756e65642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tripart_hydro_coco_5d47b5bda2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

