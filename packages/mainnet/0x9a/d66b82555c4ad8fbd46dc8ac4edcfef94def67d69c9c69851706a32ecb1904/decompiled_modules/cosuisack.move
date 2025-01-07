module 0x9ad66b82555c4ad8fbd46dc8ac4edcfef94def67d69c9c69851706a32ecb1904::cosuisack {
    struct COSUISACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: COSUISACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COSUISACK>(arg0, 9, b"coSUIsack", b"Sui Cossack", b"COSUISACK IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/070/741/951/large/stasia-bubnova-v-render-color-3.jpg?1703346551")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<COSUISACK>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COSUISACK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COSUISACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

