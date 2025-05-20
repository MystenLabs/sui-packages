module 0x324e00c574cb099fa6035a321009660376a386daf449a4784595b12bb3639a5c::meowgic {
    struct MEOWGIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOWGIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOWGIC>(arg0, 9, b"MEOWGIC", b"Meowgic", x"4973206974206c75636b3f204973206974206d616769633f2049742773204d656f77676963e280946d7973746572696f757320706177732c2073756464656e2070726f666974732c20616e64206e696e65206c6976657320776f727468206f6620687970652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/bafkreibha74yzd3jdrjklprufulpwxzzsutropp32ddvqlzon4deafzkwi")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MEOWGIC>(&mut v2, 1000000000000000000, @0x86428776defb6b37e4039efdd64fb1284e144171ea5b7b6821ab171043731cce, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOWGIC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEOWGIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

