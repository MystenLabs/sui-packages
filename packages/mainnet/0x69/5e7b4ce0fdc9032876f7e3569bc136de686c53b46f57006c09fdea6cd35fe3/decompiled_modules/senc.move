module 0x695e7b4ce0fdc9032876f7e3569bc136de686c53b46f57006c09fdea6cd35fe3::senc {
    struct SENC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SENC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SENC>(arg0, 3, b"SENC", b"Steel engineers coin", b"Best coin for steel engineers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.google.com/search?q=steel+coil+meme&client=ms-android-samsung-ss&sca_esv=e1e3193eddeaa204&udm=2&biw=384&bih=758&sxsrf=ADLYWILtH80clZkOu_awCwkwHpyf9EY4tA%3A1734508646002&ei=ZYBiZ4XnPJ_g2roPudGQkAU&oq=steel+coil+meme&gs_lp=EhJtb2JpbGUtZ3dzLXdpei1pbWciD3N0ZWVsIGNvaWwgbWVtZTIEECMYJzIIEAAYgAQYogQyCBAAGIAEGKIEMggQABiABBiiBDIIEAAYgAQYogRI8hRQAFgAcAB4AJABAJgBvwGgAb8BqgEDMC4xuAEDyAEAmAIBoALHAZgDAIgGAZIHAzAuMaAH1AM&sclient=mobile-gws-wiz-img#imgrc=CAglWGf4Jq1tBM&imgdii=iNFy-FLmTcTkCM")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SENC>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SENC>>(v2, @0xb484b1b6906e42f30dbac0ad969dc91476b5f8f33a1098b106ccd8d1aff4abeb);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SENC>>(v1);
    }

    // decompiled from Move bytecode v6
}

