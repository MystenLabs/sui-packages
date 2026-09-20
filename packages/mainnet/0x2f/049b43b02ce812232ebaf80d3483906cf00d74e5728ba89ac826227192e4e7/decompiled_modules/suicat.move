module 0x2f049b43b02ce812232ebaf80d3483906cf00d74e5728ba89ac826227192e4e7::suicat {
    struct SUICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/5872754233071833122-Qysl6epRe4ZSRWKQsakU0Wfz1VFRtt.jpg";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/5872754233071833122-Qysl6epRe4ZSRWKQsakU0Wfz1VFRtt.jpg"))
        };
        let (v2, v3) = 0x2::coin::create_currency<SUICAT>(arg0, 9, b"SUICAT", b"SUI CAT", x"466972737420436174206f6e20537569205061697265642077697468205375690a0a582068747470733a2f2f782e636f6d2f5355494341547076", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUICAT>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICAT>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<SUICAT>>(0x2::coin::mint<SUICAT>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

