module 0x1059b1de76620fb650046612b9d375cacf5339fe5af1a9e09df227610e5b2d22::gtmamoubdr {
    struct GTMAMOUBDR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTMAMOUBDR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTMAMOUBDR>(arg0, 9, 0x1::string::utf8(b"GTMAMOUBDR"), 0x1::string::utf8(b"Mr bdran"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/CGbvLC91NRo2Y8HW8gIG7LfjnSd9wCYEP1aFca2nyTAUXhQUTGuaDgK3rgidKv94CHotSNZ553v5M1GYQofPyUJnuU7DbfB4fKJzR6YkU3EgaFW04kPKoCNALZ26jO0RA_YzAfSmdxJT1v3cqc2O8mTvddWsH5cB-qMCUhB41cNn45bh45wxII3EZk12fcUmtGRbY1mGpovVCXUF_fpcXPd1xXWbZi-2GFtLSVyZHLNnJjhvUk-S9GypdL1mUKvCpSxVKikYqx4Kr_GRc-S40SLJwFG3WYiwYo6fcW3UrZKSX4U3pUEYU7sZgctJ4YbORoURCu5J78KgItM8Li-BXg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTMAMOUBDR>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTMAMOUBDR>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

