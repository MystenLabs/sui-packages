module 0xb7ba8293a2b8e81385f2020839176ecf4eab1341b08fc92572c55ea4c7b6d905::gtmaxout04 {
    struct GTMAXOUT04 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTMAXOUT04, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTMAXOUT04>(arg0, 9, 0x1::string::utf8(b"GTMAXOUT04"), 0x1::string::utf8(b"MaxOutSui"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/nPa1g_sszOz-N4sjNx6vpZZIBqorvrUoNMCZn_aNboan8YA7v7AaWTEB2ABSk0YSURZEGzrsdIzARfRMr6roBxXXanDX1LKD8G-2gay7FDi0rypZ1r3gCyJm0Oc5mS7P5CSxLkIG6W4HDQSo0VF5nA58jtBUJQW-L3GbjcnVk586mcoJbLVxpJeX6mtzT8oRQDdDjIA03wL_3qgwub5crsx4fT0zyhmrWFHLq3cuFW31qFBVtKUYkm8ya49yq6Lu9F5HMRyoet0DZGf-u0npMpeZq-x9sEdRY84gHnzwtlEw3YpsxVc_Ih4PmxEimFy7xxbJoX7Ua2Q-xSP5gSUxvw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTMAXOUT04>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTMAXOUT04>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

