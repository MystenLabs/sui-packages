module 0x3cf8c306a5b2afc196f2ddcdcd04434ca38cf7539074c2ac29dcdb9c936148a6::monkeylady {
    struct MONKEYLADY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONKEYLADY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONKEYLADY>(arg0, 9, b"monkeylady", b"Monkey Lady", b"MONKEYLADY IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/079/346/860/large/robin-r-20240826-2.jpg?1724681729")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MONKEYLADY>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKEYLADY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONKEYLADY>>(v1);
    }

    // decompiled from Move bytecode v6
}

