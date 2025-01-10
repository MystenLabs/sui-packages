module 0x3890473895ab79f792759f185a6658b201330ae40bdbc97d4cd6fd58a0564dc::ccc {
    struct CCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCC>(arg0, 9, b"CCC", b"CapyCoolCoin", b"Join us in spreading good vibes, one CapyCoolCoin at a time!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.dexscreener.com/cms/images/TqdQxw-E_o9Yq7xS?width=56&height=56&fit=crop&quality=95&format=auto")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CCC>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CCC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCC>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

