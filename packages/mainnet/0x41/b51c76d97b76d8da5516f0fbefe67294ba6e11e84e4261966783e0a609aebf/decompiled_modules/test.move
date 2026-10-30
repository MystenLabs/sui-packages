module 0x41b51c76d97b76d8da5516f0fbefe67294ba6e11e84e4261966783e0a609aebf::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::creator_authority::new_account(x"cf89b225369cf457d00d60f4359f5273bbf476a03997291a35b2c0dab9b3b4fe")
        } else {
            0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::creator_authority::new_address(0x2::address::from_bytes(x"cf89b225369cf457d00d60f4359f5273bbf476a03997291a35b2c0dab9b3b4fe"))
        };
        0x2::transfer::public_transfer<0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::launch_ticket::LaunchTicket<TEST>>(0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::launch_ticket::new<TEST>(arg0, 9, 0x1::string::utf8(b"TEST"), 0x1::string::utf8(b"test"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/98f49983c43040ea9f7d106cf15dd3bdb8e8178d924b9c69625de40c302984e5.webp"), v0, true, 0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

