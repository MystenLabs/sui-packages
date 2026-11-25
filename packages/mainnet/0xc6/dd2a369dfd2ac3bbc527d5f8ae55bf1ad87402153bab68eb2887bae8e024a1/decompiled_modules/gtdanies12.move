module 0xc6dd2a369dfd2ac3bbc527d5f8ae55bf1ad87402153bab68eb2887bae8e024a1::gtdanies12 {
    struct GTDANIES12 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTDANIES12, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTDANIES12>(arg0, 9, 0x1::string::utf8(b"GTDANIES12"), 0x1::string::utf8(b"Nani"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/OcIMJzgX4XMpNt4QgHiLa46QVtrS4ICHeS8KYk08hyatkyljhTT8pTzJgqhkPqkj79ddiDPtTGxcJQYNtTf_YlsIyVJ1QyrWROd78T6n05bCascIN7abOXdKwHkv_Os3yICHuzvnVOqA0OmuTDew7DYptIrFmvJJhSQIEPa8ie8V0CEYLesUDPj0LY7mKcQHD6L4Z6bNKCnWuVlScEQFnNLCrS7tBeO0EL0vOYxqPBDLyeaAhJttqVzN56xVloMfvptflthVfvQ25kCNx9bLg9Z0WNEVxcNXpN63knaAe0LoF3A-FoiK3zGNrIcZFtV7kU5upMQjy7JKHdH_9HXQZA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTDANIES12>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTDANIES12>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

