module 0x28b2f892a085ce05387eb86c1f4c1d020057250a3d512ba300f6c1947985f6a0::suidolf {
    struct SUIDOLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOLF>(arg0, 6, b"SUIDOLF", b"Suidolf The Blue Nose Reindeer", b"Suidolf, a young reindeer with a glowing blue nose, dreamed of making a difference. Teased by others for not having a red nose like Rudolph, he proved his worth on a snowy Christmas Eve when Santa needed a guide.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/token_icon_SD_738d291b57.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDOLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

