module 0x63ba42da849c7d2dae4fb042635b66599829b3cfcaf37d4cff2baf7c48fe0239::bala {
    struct BALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALA>(arg0, 9, b"BALA", b"Minh", x"c49061207068e1baa76e206368c3ba6e67207461207468c6b0e1bb9d6e67206368e1bb89206e6768652076c3a02074c3ac6d206b69e1babf6d2063e1bb8f2062e1bb916e206cc3a12076e1bb9b692068792076e1bb8d6e67206d6179206de1baaf6e2073e1babd207875e1baa574206869e1bb876e2e20536f6e672c206de1baa579206169206269e1babf7420c491c6b0e1bba3632072e1bab16e672c2063e1bb8f206261206cc3a12063c5a96e6720c491656d206ce1baa169206e6869e1bb817520c3bd206e6768c4a96120747579e1bb87742076e1bb9d692063686f206375e1bb99632073e1bb916e67", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2dabd2c2-e233-4aba-b760-0f098c39610d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BALA>>(v1);
    }

    // decompiled from Move bytecode v6
}

