module 0xb1622c9256fd3689dbef012b0bc7f0438246149fc7fa74b99ec368b050a1128d::nvidia {
    struct NVIDIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NVIDIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<NVIDIA>(arg0, 9, 0x1::string::utf8(b"NVIDIA"), 0x1::string::utf8(b"nvidia"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/8f993db0b7bdf0250156a2fc5a2e82812ffa944ea93d9980f1ccba2d406e3bb8.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<NVIDIA>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<NVIDIA>>(0x2::coin_registry::finalize<NVIDIA>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<NVIDIA>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

