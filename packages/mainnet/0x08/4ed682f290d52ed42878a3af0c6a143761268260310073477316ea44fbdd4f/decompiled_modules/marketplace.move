module 0x10060284412fe122d500bcead4c5cd0f07af65d443d456913dd5b1203aeef961::marketplace {
    struct Listed has copy, drop {
        nft_id: 0x2::object::ID,
        price: u64,
        seller: address,
    }

    struct Delisted has copy, drop {
        nft_id: 0x2::object::ID,
        seller: address,
    }

    struct Purchased has copy, drop {
        nft_id: 0x2::object::ID,
        buyer: address,
    }

    public fun list(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x10060284412fe122d500bcead4c5cd0f07af65d443d456913dd5b1203aeef961::todaynft::TodayNFT, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x10060284412fe122d500bcead4c5cd0f07af65d443d456913dd5b1203aeef961::todaynft::TodayNFT>(&arg2);
        0x2::kiosk::place<0x10060284412fe122d500bcead4c5cd0f07af65d443d456913dd5b1203aeef961::todaynft::TodayNFT>(arg0, arg1, arg2);
        0x2::kiosk::list<0x10060284412fe122d500bcead4c5cd0f07af65d443d456913dd5b1203aeef961::todaynft::TodayNFT>(arg0, arg1, v0, arg3);
        let v1 = Listed{
            nft_id : v0,
            price  : arg3,
            seller : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<Listed>(v1);
    }

    public fun purchase(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::transfer_policy::TransferPolicy<0x10060284412fe122d500bcead4c5cd0f07af65d443d456913dd5b1203aeef961::todaynft::TodayNFT>, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::purchase<0x10060284412fe122d500bcead4c5cd0f07af65d443d456913dd5b1203aeef961::todaynft::TodayNFT>(arg0, arg1, arg2);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0x10060284412fe122d500bcead4c5cd0f07af65d443d456913dd5b1203aeef961::todaynft::TodayNFT>(arg3, v1);
        0x2::transfer::public_transfer<0x10060284412fe122d500bcead4c5cd0f07af65d443d456913dd5b1203aeef961::todaynft::TodayNFT>(v0, 0x2::tx_context::sender(arg4));
        let v5 = Purchased{
            nft_id : arg1,
            buyer  : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<Purchased>(v5);
    }

    public fun delist_and_withdraw(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::kiosk::delist<0x10060284412fe122d500bcead4c5cd0f07af65d443d456913dd5b1203aeef961::todaynft::TodayNFT>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x10060284412fe122d500bcead4c5cd0f07af65d443d456913dd5b1203aeef961::todaynft::TodayNFT>(0x2::kiosk::take<0x10060284412fe122d500bcead4c5cd0f07af65d443d456913dd5b1203aeef961::todaynft::TodayNFT>(arg0, arg1, arg2), 0x2::tx_context::sender(arg3));
        let v0 = Delisted{
            nft_id : arg2,
            seller : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<Delisted>(v0);
    }

    // decompiled from Move bytecode v7
}

