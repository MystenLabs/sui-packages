module 0xa2e55172fec64c1d5cfb89dc55839dd579937aa23e7ce2280b0937efb2b87887::pre {
    struct PRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRE>(arg0, 4, b"PRE", b"PRE", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://premiumexchange.top/images/logo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<PRE>>(0x2::coin::mint<PRE>(&mut v2, 100000000000000, arg1), @0x7d6cb078ddcd34f99af3f12d47642611f0a4aa5d918decdf0519f830307648b8);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PRE>>(v2);
    }

    // decompiled from Move bytecode v6
}

