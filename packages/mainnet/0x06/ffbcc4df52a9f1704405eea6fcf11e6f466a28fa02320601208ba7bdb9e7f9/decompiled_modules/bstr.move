module 0x6ffbcc4df52a9f1704405eea6fcf11e6f466a28fa02320601208ba7bdb9e7f9::bstr {
    struct BSTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<BSTR>(arg0, 9, 0x1::string::utf8(b"BSTR"), 0x1::string::utf8(b"Blasttor"), 0x1::string::utf8(b"Hellyeah, we are go to the moon baby"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/f125828e8348eb250726c944bcf3cf3687bf3120c364d35988acaeaeab7cc059.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BSTR>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<BSTR>>(0x2::coin_registry::finalize<BSTR>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<BSTR>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

