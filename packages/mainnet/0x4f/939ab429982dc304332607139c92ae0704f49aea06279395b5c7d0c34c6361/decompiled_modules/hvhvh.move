module 0x4f939ab429982dc304332607139c92ae0704f49aea06279395b5c7d0c34c6361::hvhvh {
    struct HVHVH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HVHVH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HVHVH>(arg0, 9, b"HVHVH", b"Yvyv", b"Vhvhvhv", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/76a3066f-12e7-414b-8b6d-badb0270778b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HVHVH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HVHVH>>(v1);
    }

    // decompiled from Move bytecode v6
}

