module 0xa4efd0f1322933621f59ea63ca06f77d4bb94230cb3357b3eeadc77004d4111::strategio_testo {
    struct STRATEGIO_TESTO has drop {
        dummy_field: bool,
    }

    struct StrategioTesto has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
    }

    fun init(arg0: STRATEGIO_TESTO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<STRATEGIO_TESTO>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        let v5 = 0x2::display::new_with_fields<StrategioTesto>(&v0, v1, v3, arg1);
        0x2::display::update_version<StrategioTesto>(&mut v5);
        let (v6, v7) = 0x2::transfer_policy::new<StrategioTesto>(&v0, arg1);
        let v8 = v7;
        let v9 = v6;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<StrategioTesto>(&mut v9, &v8);
        let (v10, v11) = 0x2::kiosk::new(arg1);
        let v12 = v11;
        let v13 = v10;
        let v14 = vector[b"Alpha1", b"Bravo2", b"Charlie3", b"Delta4", b"Echo5", b"Foxtrot6", b"Golf7", b"Hotel8", b"India9", b"Juliet10", b"Kilo11", b"Lima12", b"Mike13", b"November14", b"Oscar15", b"Papa16", b"Quebec17", b"Romeo18", b"Sierra19", b"Tango20"];
        let v15 = vector[b"Bold and decisive leader of the pack", b"Courageous explorer of uncharted territories", b"Charming strategist with a sharp mind", b"Steadfast defender of the realm", b"Resonant voice that carries through mountains", b"Graceful dancer in the fog of war", b"Precise player on the green of fate", b"Welcoming host of grand gatherings", b"Mystical seeker of ancient wisdom", b"Passionate heart beneath the moonlight", b"Measured force weighed in golden balance", b"Vibrant spirit from the coastal shores", b"Reliable companion through every mission", b"Enduring presence in the autumn breeze", b"Distinguished achiever of great honors", b"Wise guardian of sacred traditions", b"Unique visionary from the northern lands", b"Devoted romantic chasing timeless dreams", b"Majestic peak rising above the clouds", b"Rhythmic soul moving to life's beat"];
        let v16 = vector[b"https://picsum.photos/seed/strategio0/400/400", b"https://picsum.photos/seed/strategio1/400/400", b"https://picsum.photos/seed/strategio2/400/400", b"https://picsum.photos/seed/strategio3/400/400", b"https://picsum.photos/seed/strategio4/400/400", b"https://picsum.photos/seed/strategio5/400/400", b"https://picsum.photos/seed/strategio6/400/400", b"https://picsum.photos/seed/strategio7/400/400", b"https://picsum.photos/seed/strategio8/400/400", b"https://picsum.photos/seed/strategio9/400/400", b"https://picsum.photos/seed/strategio10/400/400", b"https://picsum.photos/seed/strategio11/400/400", b"https://picsum.photos/seed/strategio12/400/400", b"https://picsum.photos/seed/strategio13/400/400", b"https://picsum.photos/seed/strategio14/400/400", b"https://picsum.photos/seed/strategio15/400/400", b"https://picsum.photos/seed/strategio16/400/400", b"https://picsum.photos/seed/strategio17/400/400", b"https://picsum.photos/seed/strategio18/400/400", b"https://picsum.photos/seed/strategio19/400/400"];
        let v17 = 0;
        while (v17 < 20) {
            let v18 = StrategioTesto{
                id          : 0x2::object::new(arg1),
                name        : 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&v14, v17)),
                description : 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&v15, v17)),
                image_url   : 0x2::url::new_unsafe_from_bytes(*0x1::vector::borrow<vector<u8>>(&v16, v17)),
            };
            0x2::kiosk::lock<StrategioTesto>(&mut v13, &v12, &v9, v18);
            v17 = v17 + 1;
        };
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<StrategioTesto>>(v8, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v12, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<StrategioTesto>>(v9);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v13);
        0x2::transfer::public_share_object<0x2::display::Display<StrategioTesto>>(v5);
    }

    // decompiled from Move bytecode v6
}

