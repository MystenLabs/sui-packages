module 0xb42dbae22a1bf0c046643bf71d8de18a5c787fa0af3f47ad61e6b1810333d45d::slothstack {
    struct SLOTHSTACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOTHSTACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLOTHSTACK>(arg0, 9, b"SLOTHSTACK", b"Slothstack", x"536c6f7720616e64207374656164792077696e732074686520726163652e20536c6f7468737461636b20636c696d627320796f757220706f7274666f6c696f20736c6f776c792062757420737572656c79e280946e6f20727573682c206a757374206368696c6c2c2070757265206761696e732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/bafkreihjyd7qqsecbfno447ipx7q2vagwnhhw7flwonqxfss44ngedob3u")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SLOTHSTACK>(&mut v2, 1000000000000000000, @0x86428776defb6b37e4039efdd64fb1284e144171ea5b7b6821ab171043731cce, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOTHSTACK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLOTHSTACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

