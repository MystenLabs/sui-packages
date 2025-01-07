module 0x6f15684f5002d9040f71ba78ab9e92e7119139507012adfe32157278b52eb86d::bpug {
    struct BPUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BPUG>(arg0, 6, b"BPUG", b"Baby Pug", x"20424f524e2046524f4d20544845204f472c2046554420544845205055472c0a244250554720495320524541445920544f20535445414c205448450a53504f544c49474854204f4e20535549212020574954482049545320435554450a425554204d495343484945564f555320434841524d2c20424142590a505547204953204845524520544f204241524b204954532057415920544f0a54484520544f502c2057414747494e47205441494c5320414e440a57494e4e494e472048454152545320414c4f4e47205448452057415921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731185878974.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BPUG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPUG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

