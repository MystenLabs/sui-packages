module 0xbe1af5ef6e6ffa70a298947fd173932e24f98aa1488d77875bee1eff747e107c::nncat {
    struct NNCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NNCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/ERA2E-ajxhi6q4Q14HRlfjfcxqdqE13tD6qX.jpg";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/ERA2E-ajxhi6q4Q14HRlfjfcxqdqE13tD6qX.jpg"))
        };
        let (v2, v3) = 0x2::coin::create_currency<NNCAT>(arg0, 9, b"NNCAT", b"nncat", b"tes", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NNCAT>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NNCAT>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<NNCAT>>(0x2::coin::mint<NNCAT>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

