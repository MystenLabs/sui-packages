module 0x66418cc211887d4b321fc24864469dad107cd358d75a19b6cf4f0d666d0af798::gtborneotr {
    struct GTBORNEOTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTBORNEOTR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTBORNEOTR>(arg0, 9, 0x1::string::utf8(b"GTBORNEOTR"), 0x1::string::utf8(b"Lera Delta"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/q0mrFD3AySTCZpAtrjbS0tBl0R4bPyLZwjwm2BS3rDNauz6tzmuiekud-36U3fGNqwo71tLT2_EE9rfyxZ3WfrP5HIskBMOMa60xKuptrO6rucH1T6GGcENYbRPYMo442cahA7icJwnqTveV2UD_TanwBjxNLWQWh0TbNZNSr3v9jueeKJ2k6zDBm5cu9Txk_wzVIXRYoxAhhrgosht4P8MTZKwIemRB0oUuQYv9_PfauMxzl8UPFL5iQZnCoi5MWDbbKovviWSZxGxB99L28bMGcGDqZhGWFMJY8-7AM1QcNuPe9Q0bTHACQWtGP3PTE1oN8SdpDPIXDzEPFZaAuw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTBORNEOTR>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTBORNEOTR>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

