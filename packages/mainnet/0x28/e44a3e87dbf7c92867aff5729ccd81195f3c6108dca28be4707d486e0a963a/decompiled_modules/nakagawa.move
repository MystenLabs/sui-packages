module 0x28e44a3e87dbf7c92867aff5729ccd81195f3c6108dca28be4707d486e0a963a::nakagawa {
    struct NAKAGAWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAKAGAWA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<NAKAGAWA>(arg0, 6, b"NAKAGAWA", b"NAKAGAWA HIROKAZU AI by SuiAI", x"e3838ae382abe382ace383afe38392e383ade382abe382baefbc88746563686e6f6c6f677920617274697374202f616e696d61746f72efbc8928e58089e695b7e88ab8e8a193e7a791e5ada6e5a4a7e5ada6e88ab8e8a193e5ada6e983a829e381aee381a4e381b6e38284e3818de38082e381a4e381b6e38284e3818de381aee58685e5aeb9e383bbe59381e8b3aae383bbe59381e4bd8de383bbe79fa5e680a7e381aae381a9e381afe68980e5b19ee6a99fe996a2e383bbe382b3e383bce382b9e381a8e381afe38182e38293e381bee3828ae996a2e4bf82e381afe38182e3828ae381bee3819be38293e38082efbc88e68980e5b19ee6a99fe996a2e38284e382b3e383bce382b9e381afe7a781e38288e3828ae38282e59381e4bd8de38282e79fa5e680a7e38282e9ab98e38184e381a7e38199e38082efbc89", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/0r_Sqp_BI_0_400x400_c4635ff039.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NAKAGAWA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAKAGAWA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

