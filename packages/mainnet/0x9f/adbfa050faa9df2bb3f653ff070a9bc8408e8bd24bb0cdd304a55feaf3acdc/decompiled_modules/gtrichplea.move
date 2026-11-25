module 0x9fadbfa050faa9df2bb3f653ff070a9bc8408e8bd24bb0cdd304a55feaf3acdc::gtrichplea {
    struct GTRICHPLEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTRICHPLEA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTRICHPLEA>(arg0, 9, 0x1::string::utf8(b"GTRICHPLEA"), 0x1::string::utf8(b"Red ass09"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/cItks7tyIOmsDcdeH_qLhzlTNhCQvnnHG8X-VUdUIZQRA9WhDGjWT7ae1om8S1EICcqysPQBYqKRi4JLQ9y9wpYyIfRKWrgXeB4CRmJDMQ9vfVqX8q-yIwzTWzNo2mkhIHxNcB8Hgxre6X39w7PjiFhIjVm9GgrU3MbPCd1vz9V7SIRHaISO0fAWuMpr6YnOA-8QuIaQGmypluJD7Z19BoPwVh2qPaKg_HX3ZouGqlgnl9TfvfR7G9H_oquh0c47ZJKIm-_8Eb_90_8TsFriC8qdVtTg7n6OdTjXkmE1HuclalEJqBJYzZgjnQq1WhSYPIaCnf02PMeGQq60wB6WdA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTRICHPLEA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTRICHPLEA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

