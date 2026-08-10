module 0xe5d1af41cfdbae4e2597ad392f3bf0f6bb51b4d25925d9c2da563eb9629549c0::sui_cyber_otter {
    struct SUI_CYBER_OTTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_CYBER_OTTER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sponsor(arg1);
        assert!(0x1::option::is_some<address>(&v0), 1);
        assert!(0x1::option::extract<address>(&mut v0) == @0x4e3803889934c26540965b8684454a380cecdae5984bdf0e111721a3785d57d2, 2);
        assert!(0x2::tx_context::epoch(arg1) == 1215 || 0x2::tx_context::epoch(arg1) == 1216, 0);
        let (v1, v2) = 0x2::coin::create_currency<SUI_CYBER_OTTER>(arg0, 9, b"Otter", b"Sui Cyber Otter", x"5468652066697273742066756c6c79206175746f6e6f6d6f7573204149204f74746572206275696c74206f6e20537569204d6f76652e205768696c6520796f7520736c6565702c20244f54544552207377696d73207468652064656570206c697175696469747920706f6f6c7320746f20636174636820746865206269676765737420666973682e204e6f20726f61646d6170732c206a7573742070757265206171756174696320766962657320616e6420686967682d7370656564207472616e73616374696f6e732e20f09fa6a6f09f92bbf09f8c8a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.20lab.app/ipfs/QmTdb8niZHo1Kr4cXiNVP4sViisHHhFbgaFaCjmLyauvTL"))), arg1);
        let v3 = v1;
        0x2::coin::mint_and_transfer<SUI_CYBER_OTTER>(&mut v3, 1000000000000000000, @0xb8cd5bf4af2cebdb05da6c17ecc9460cb0d34214f5e1925a7a0a72a9488ed02, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_CYBER_OTTER>>(v3, @0xb8cd5bf4af2cebdb05da6c17ecc9460cb0d34214f5e1925a7a0a72a9488ed02);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_CYBER_OTTER>>(v2);
    }

    // decompiled from Move bytecode v6
}

