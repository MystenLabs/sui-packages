module 0xe34845c964658badbd68898ec4438672160170c21f5d293296b049f77bf21ef4::ket {
    struct KET has drop {
        dummy_field: bool,
    }

    fun init(arg0: KET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KET>(arg0, 9, b"KET", b"KetamineCat", b"...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/3nh4AYBcNDUmXPZ9eaF4j22cqpMi593PVeXv1sMUpump.png?size=xl&key=47d63c")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KET>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KET>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KET>>(v1);
    }

    // decompiled from Move bytecode v6
}

