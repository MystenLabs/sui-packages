module 0xde056c635e45098cf10fff734778123a5f0df740114b944c048ec4443e9e6325::gtkitakits {
    struct GTKITAKITS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTKITAKITS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTKITAKITS>(arg0, 9, 0x1::string::utf8(b"GTKITAKITS"), 0x1::string::utf8(b"kitakitsune"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/O7uQxB7oXVr9DIM0qacUANu7H7dX0RVMWMvB5E9oC2QlpiVq8-sFl8eZ2hXrYfd1vCBJRjWR8c8J-QqKcr8BjaJh3TNbm1D8IVCujEBzpFr-RbFnUIuTR_Sa7KDUY_KwV7bUGtHzC7Z9KqPDOlA6kaXyE01LnzWEt9MdxN0qE6fTZeW3zimKuirQMioEvXzV32QsP-nP6NtuVEjxUU6vgh73UZ1lUowCIJSw1wVnr0mBF-uVisDxMVQfOGLCD0quzm5gRXOyI7Y0IXuxv0THAlnfXY_HbXGX8DzGUmTPpsp0zceCyaOXkQYK_v8LKc1uWBnT_FCmSz0X387WQuU9ZA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTKITAKITS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTKITAKITS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

