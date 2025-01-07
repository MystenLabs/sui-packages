module 0xa21206bc8f1466a8d93794d69c15d25dfca14a4db19ebdf4f48afea2ff3edbcc::dip {
    struct DIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIP>(arg0, 6, b"DIP", b"Dippy", x"244449502069732070726f6261626c79206e6f7468696e67210a0a446970707920697320686572652c200a0a57652061726520612062756e6368206f66206469727479206361747320746861742077696c6c2074726f6c6c696e672061726f756e64206f6e20535549210a416c6c207765206e656564206973206a7573742061206c696c2066697368626f6e6520616e64206368616f73210a0a4255592054484520244449500a57414954494e4720464f52205448452046454b494e2024444950", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_13_12_26_23_7fed25540d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

