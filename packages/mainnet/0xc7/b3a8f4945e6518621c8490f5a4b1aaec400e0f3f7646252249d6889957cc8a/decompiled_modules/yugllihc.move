module 0xc7b3a8f4945e6518621c8490f5a4b1aaec400e0f3f7646252249d6889957cc8a::yugllihc {
    struct YUGLLIHC has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUGLLIHC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUGLLIHC>(arg0, 6, b"YUGLLIHC", b"Yug Llihc A Tsuj", b".fag yllaer t'nseod yeK-woL dna yug llihc a yllaer si eh si laed elohw siH ,yuglliHC$ gnicudortnI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_8e61d41ee2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUGLLIHC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YUGLLIHC>>(v1);
    }

    // decompiled from Move bytecode v6
}

