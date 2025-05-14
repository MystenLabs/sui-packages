module 0xd1844f59d72827b5643882d522cb4d0498d7c4697c8da2c0a53fae125cffc952::sroom_token {
    struct SROOM_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SROOM_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SROOM_TOKEN>(arg0, 9, b"SHR0", b"SroomAI DAO", b"Official token of MoonBags", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifyfk4bbt5eardsd3bsb7t4vwwhwtw6ssigcmdoxqaz4vccczjbeq")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SROOM_TOKEN>(&mut v2, 1100000000000000000, @0x86d23a68cdddbdb748c8d40aa226afed8e5f87c5d5dc8e904c13971759339c73, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SROOM_TOKEN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SROOM_TOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

