module 0xb2daa0a5df361c956e151ab0b331dfcbb09e470bfa22ef745cf734b582a48f32::crabsolutely {
    struct CRABSOLUTELY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRABSOLUTELY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRABSOLUTELY>(arg0, 9, b"CRABSOLUTELY", b"Crabsolutely", b"Side-stepping FUD since day one! Crabsolutely keeps cool under pressure, always holding sideways with stubborn optimism.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/bafkreia7raem7nivvx6sh6glwhfvtxjtke5vdefbitz37idrfqa77tftla")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CRABSOLUTELY>(&mut v2, 1000000000000000000, @0x86428776defb6b37e4039efdd64fb1284e144171ea5b7b6821ab171043731cce, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRABSOLUTELY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRABSOLUTELY>>(v1);
    }

    // decompiled from Move bytecode v6
}

