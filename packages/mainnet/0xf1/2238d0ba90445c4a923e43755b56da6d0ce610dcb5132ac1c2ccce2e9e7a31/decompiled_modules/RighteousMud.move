module 0xf12238d0ba90445c4a923e43755b56da6d0ce610dcb5132ac1c2ccce2e9e7a31::RighteousMud {
    struct RIGHTEOUSMUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIGHTEOUSMUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIGHTEOUSMUD>(arg0, 0, b"COS", b"Righteous Mud", b"Cleanse not this mark of regal solitude... this honor of a kingdom at rest...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Body_Righteous_Mud.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RIGHTEOUSMUD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIGHTEOUSMUD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

