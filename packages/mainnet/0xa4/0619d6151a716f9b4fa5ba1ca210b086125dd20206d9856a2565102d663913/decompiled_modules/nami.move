module 0xa40619d6151a716f9b4fa5ba1ca210b086125dd20206d9856a2565102d663913::nami {
    struct NAMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAMI>(arg0, 6, b"NAMI", b"NAMI SUI", x"4e414d49535549206973206865726520746f207269646520746865207761766573200a57652061726520746872696c6c656420746f20616e6e6f756e6365206f75722073747261746567696320706172746e657273686970207769746820594f55520a20746f20656c65766174652074686520237375696e616d6920746f20756e707265636564656e74656420686569676874732120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zxc9_V86w_400x400_70d11cd8fb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

