module 0xc197f8b1bc5cbc60d50a9042702b4d299804031d555b7ddef6baeed93a13e89a::kiosk {
    struct KIOSK has drop {
        dummy_field: bool,
    }

    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        amount_bp: u16,
        min_amount: u64,
    }

    public(friend) fun list(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: u64) {
        0x2::kiosk::list<0xc197f8b1bc5cbc60d50a9042702b4d299804031d555b7ddef6baeed93a13e89a::nft::Nft>(arg0, arg1, arg2, arg3);
    }

    public(friend) fun place(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0xc197f8b1bc5cbc60d50a9042702b4d299804031d555b7ddef6baeed93a13e89a::nft::Nft) {
        0x2::kiosk::place<0xc197f8b1bc5cbc60d50a9042702b4d299804031d555b7ddef6baeed93a13e89a::nft::Nft>(arg0, arg1, arg2);
    }

    public fun confirm_request(arg0: &0x2::transfer_policy::TransferPolicy<0xc197f8b1bc5cbc60d50a9042702b4d299804031d555b7ddef6baeed93a13e89a::nft::Nft>, arg1: 0x2::transfer_policy::TransferRequest<0xc197f8b1bc5cbc60d50a9042702b4d299804031d555b7ddef6baeed93a13e89a::nft::Nft>) : (0x2::object::ID, u64, 0x2::object::ID) {
        0x2::transfer_policy::confirm_request<0xc197f8b1bc5cbc60d50a9042702b4d299804031d555b7ddef6baeed93a13e89a::nft::Nft>(arg0, arg1)
    }

    public fun add_royalty_rule(arg0: &mut 0x2::transfer_policy::TransferPolicy<0xc197f8b1bc5cbc60d50a9042702b4d299804031d555b7ddef6baeed93a13e89a::nft::Nft>, arg1: &0x2::transfer_policy::TransferPolicyCap<0xc197f8b1bc5cbc60d50a9042702b4d299804031d555b7ddef6baeed93a13e89a::nft::Nft>, arg2: u16, arg3: u64) {
        assert!(arg2 <= 5000, 0);
        let v0 = Rule{dummy_field: false};
        let v1 = Config{
            amount_bp  : arg2,
            min_amount : arg3,
        };
        0x2::transfer_policy::add_rule<0xc197f8b1bc5cbc60d50a9042702b4d299804031d555b7ddef6baeed93a13e89a::nft::Nft, Rule, Config>(v0, arg0, arg1, v1);
    }

    public fun buy(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>) : (0xc197f8b1bc5cbc60d50a9042702b4d299804031d555b7ddef6baeed93a13e89a::nft::Nft, 0x2::transfer_policy::TransferRequest<0xc197f8b1bc5cbc60d50a9042702b4d299804031d555b7ddef6baeed93a13e89a::nft::Nft>) {
        0x2::kiosk::purchase<0xc197f8b1bc5cbc60d50a9042702b4d299804031d555b7ddef6baeed93a13e89a::nft::Nft>(arg0, arg1, arg2)
    }

    public fun fee_amount(arg0: &0x2::transfer_policy::TransferPolicy<0xc197f8b1bc5cbc60d50a9042702b4d299804031d555b7ddef6baeed93a13e89a::nft::Nft>, arg1: u64) : u64 {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x2::transfer_policy::get_rule<0xc197f8b1bc5cbc60d50a9042702b4d299804031d555b7ddef6baeed93a13e89a::nft::Nft, Rule, Config>(v0, arg0);
        let v2 = (((arg1 as u128) * (v1.amount_bp as u128) / 10000) as u64);
        if (v2 < v1.min_amount) {
            v1.min_amount
        } else {
            v2
        }
    }

    fun init(arg0: KIOSK, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<KIOSK>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public(friend) fun new_kiosk(arg0: &mut 0x2::tx_context::TxContext) : (0x2::kiosk::Kiosk, 0x2::kiosk::KioskOwnerCap) {
        0x2::kiosk::new(arg0)
    }

    public fun new_policy(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : (0x2::transfer_policy::TransferPolicy<0xc197f8b1bc5cbc60d50a9042702b4d299804031d555b7ddef6baeed93a13e89a::nft::Nft>, 0x2::transfer_policy::TransferPolicyCap<0xc197f8b1bc5cbc60d50a9042702b4d299804031d555b7ddef6baeed93a13e89a::nft::Nft>) {
        0x2::transfer_policy::new<0xc197f8b1bc5cbc60d50a9042702b4d299804031d555b7ddef6baeed93a13e89a::nft::Nft>(arg0, arg1)
    }

    public fun pay_royalty(arg0: &mut 0x2::transfer_policy::TransferPolicy<0xc197f8b1bc5cbc60d50a9042702b4d299804031d555b7ddef6baeed93a13e89a::nft::Nft>, arg1: &mut 0x2::transfer_policy::TransferRequest<0xc197f8b1bc5cbc60d50a9042702b4d299804031d555b7ddef6baeed93a13e89a::nft::Nft>, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == fee_amount(arg0, 0x2::transfer_policy::paid<0xc197f8b1bc5cbc60d50a9042702b4d299804031d555b7ddef6baeed93a13e89a::nft::Nft>(arg1)), 1);
        let v0 = Rule{dummy_field: false};
        0x2::transfer_policy::add_to_balance<0xc197f8b1bc5cbc60d50a9042702b4d299804031d555b7ddef6baeed93a13e89a::nft::Nft, Rule>(v0, arg0, arg2);
        let v1 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<0xc197f8b1bc5cbc60d50a9042702b4d299804031d555b7ddef6baeed93a13e89a::nft::Nft, Rule>(v1, arg1);
    }

    public(friend) fun withdraw(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID) : 0xc197f8b1bc5cbc60d50a9042702b4d299804031d555b7ddef6baeed93a13e89a::nft::Nft {
        0x2::kiosk::take<0xc197f8b1bc5cbc60d50a9042702b4d299804031d555b7ddef6baeed93a13e89a::nft::Nft>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

