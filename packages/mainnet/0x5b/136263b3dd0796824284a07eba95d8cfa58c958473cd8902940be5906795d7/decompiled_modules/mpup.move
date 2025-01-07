module 0x5b136263b3dd0796824284a07eba95d8cfa58c958473cd8902940be5906795d7::mpup {
    struct MPUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MPUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MPUP>(arg0, 6, b"MPUP", b"Move Pum's Pup", b"Blue dog is representing the Move's color and will be the mascot of this platform. Who let the dog's out: Move Pump Pup Pup", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_09_02_13_35_35_A_realistic_blue_dog_with_a_shiny_blue_coat_energetically_celebrating_the_launch_of_the_Move_Pump_platform_The_dog_is_depicted_in_a_joyful_pose_p_085bacc7c0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MPUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MPUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

