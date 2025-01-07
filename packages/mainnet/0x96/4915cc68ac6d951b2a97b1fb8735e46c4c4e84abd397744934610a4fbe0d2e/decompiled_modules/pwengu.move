module 0x964915cc68ac6d951b2a97b1fb8735e46c4c4e84abd397744934610a4fbe0d2e::pwengu {
    struct PWENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PWENGU>(arg0, 6, b"PWENGU", b"Pwengu", b"Hey there! I'm Pwengu  the fluffiest, cutest, and most playful penguin straight from the Arctic! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Vi_T_Gz_Qh_400x400_4362241fd1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PWENGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PWENGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

