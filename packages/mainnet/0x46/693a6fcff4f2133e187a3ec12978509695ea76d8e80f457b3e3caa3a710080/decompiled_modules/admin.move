module 0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ADMIN has drop {
        dummy_field: bool,
    }

    entry fun add_supporting_coin_type(arg0: &AdminCap, arg1: &mut 0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::multisig_escrow::Listings, arg2: 0x1::string::String) {
        0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::multisig_escrow::add_supporting_coin_type(arg1, arg2);
    }

    fun init(arg0: ADMIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<ADMIN>(arg0, arg1);
        let v1 = 0x2::display::new<0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::item::Item>(&v0, arg1);
        0x2::display::add<0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::item::Item>(&mut v1, 0x1::string::utf8(b"asset_id"), 0x1::string::utf8(b"{asset_id}"));
        0x2::display::add<0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::item::Item>(&mut v1, 0x1::string::utf8(b"asset_type"), 0x1::string::utf8(b"{asset_type}"));
        0x2::display::add<0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::item::Item>(&mut v1, 0x1::string::utf8(b"asset_group_id"), 0x1::string::utf8(b"{asset_group_id}"));
        0x2::display::add<0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::item::Item>(&mut v1, 0x1::string::utf8(b"version"), 0x1::string::utf8(b"{version}"));
        0x2::display::add<0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::item::Item>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::item::Item>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::item::Item>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::update_version<0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::item::Item>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::item::Item>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::item::AssetSigner>(0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::item::new_asset_signer(b"", arg1));
    }

    entry fun remove_supporting_coin_type(arg0: &AdminCap, arg1: &mut 0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::multisig_escrow::Listings, arg2: 0x1::string::String) {
        0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::multisig_escrow::remove_supporting_coin_type(arg1, arg2);
    }

    entry fun set_asset_signer(arg0: &AdminCap, arg1: &mut 0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::item::AssetSigner, arg2: vector<u8>) {
        0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::item::set_asset_signer(arg1, arg2);
    }

    entry fun set_fee_rate(arg0: &AdminCap, arg1: &mut 0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::multisig_escrow::Listings, arg2: u64) {
        0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::multisig_escrow::set_fee_rate(arg1, arg2);
    }

    entry fun set_fee_recipient(arg0: &AdminCap, arg1: &mut 0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::multisig_escrow::Listings, arg2: address) {
        0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::multisig_escrow::set_fee_recipient(arg1, arg2);
    }

    entry fun set_listing_signer(arg0: &AdminCap, arg1: &mut 0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::multisig_escrow::Listings, arg2: vector<u8>) {
        0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::multisig_escrow::set_signer_public_key(arg1, arg2);
    }

    entry fun set_warranty_price_recipient(arg0: &AdminCap, arg1: &mut 0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::multisig_escrow::Listings, arg2: address) {
        0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::multisig_escrow::set_warranty_price_recipient(arg1, arg2);
    }

    entry fun warranty_pay_for_ticket<T0>(arg0: &AdminCap, arg1: 0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::warranty::WarrantyClaimTicket, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x46693a6fcff4f2133e187a3ec12978509695ea76d8e80f457b3e3caa3a710080::warranty::pay_for_ticket<T0>(arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

