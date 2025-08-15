module 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::paid_services {
    public entry fun bribe_police_paid(arg0: &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::billing::BillingConfig, arg3: &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::billing::Treasury, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::errors::assert_is_arrested(0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression::is_arrested(0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::wanted(arg0)));
        let v0 = 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::billing::charge(arg1, 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::police_bribe_price(), arg2, arg3, arg5);
        if (0x2::coin::value<0x2::sui::SUI>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg5));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
        };
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression::escape_arrest(0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::wanted_mut(arg0), 0x2::clock::timestamp_ms(arg4));
    }

    public fun calculate_police_bribe_cost(arg0: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::billing::BillingConfig) : u64 {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::billing::calculate_final_price(0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::police_bribe_price(), arg0)
    }

    public fun calculate_stamina_restore_cost(arg0: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::billing::BillingConfig) : u64 {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::billing::calculate_final_price(0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::stamina_restore_price(), arg0)
    }

    public fun can_character_raid(arg0: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character) : bool {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::can_raid(arg0)
    }

    public fun get_wanted_level(arg0: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character) : u64 {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression::wanted_level(0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::wanted(arg0))
    }

    public fun is_character_arrested(arg0: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character) : bool {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression::is_arrested(0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::wanted(arg0))
    }

    public fun needs_stamina_restore(arg0: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character) : bool {
        let v0 = 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::stamina(arg0);
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression::stamina_current(v0) < 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression::stamina_max(v0)
    }

    public entry fun restore_stamina_paid(arg0: &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::billing::BillingConfig, arg3: &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::billing::Treasury, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::billing::charge(arg1, 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::stamina_restore_price(), arg2, arg3, arg5);
        if (0x2::coin::value<0x2::sui::SUI>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg5));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
        };
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression::restore_stamina_full(0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::stamina_mut(arg0), 0x2::clock::timestamp_ms(arg4));
    }

    // decompiled from Move bytecode v6
}

