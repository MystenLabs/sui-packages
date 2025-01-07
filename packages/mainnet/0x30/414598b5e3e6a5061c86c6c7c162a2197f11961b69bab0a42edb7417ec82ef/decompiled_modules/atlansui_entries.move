module 0x30414598b5e3e6a5061c86c6c7c162a2197f11961b69bab0a42edb7417ec82ef::atlansui_entries {
    public entry fun accept_offer_with_nft<T0, T1: store + key>(arg0: &mut 0x30414598b5e3e6a5061c86c6c7c162a2197f11961b69bab0a42edb7417ec82ef::atlansui::Platform, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: T1, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x30414598b5e3e6a5061c86c6c7c162a2197f11961b69bab0a42edb7417ec82ef::atlansui::accept_offer_with_nft<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun cancel_offer<T0, T1: store + key>(arg0: &mut 0x30414598b5e3e6a5061c86c6c7c162a2197f11961b69bab0a42edb7417ec82ef::atlansui::Platform, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x30414598b5e3e6a5061c86c6c7c162a2197f11961b69bab0a42edb7417ec82ef::atlansui::cancel_offer<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun claim_offer<T0, T1: store + key>(arg0: &mut 0x30414598b5e3e6a5061c86c6c7c162a2197f11961b69bab0a42edb7417ec82ef::atlansui::Platform, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x30414598b5e3e6a5061c86c6c7c162a2197f11961b69bab0a42edb7417ec82ef::atlansui::claim_offer<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun create_collection<T0, T1: store + key>(arg0: &mut 0x30414598b5e3e6a5061c86c6c7c162a2197f11961b69bab0a42edb7417ec82ef::atlansui::Platform, arg1: &mut 0x30414598b5e3e6a5061c86c6c7c162a2197f11961b69bab0a42edb7417ec82ef::atlansui::AdminCap, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x30414598b5e3e6a5061c86c6c7c162a2197f11961b69bab0a42edb7417ec82ef::atlansui::create_collection<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun create_offer<T0, T1: store + key>(arg0: &mut 0x30414598b5e3e6a5061c86c6c7c162a2197f11961b69bab0a42edb7417ec82ef::atlansui::Platform, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x30414598b5e3e6a5061c86c6c7c162a2197f11961b69bab0a42edb7417ec82ef::atlansui::create_offer<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun repayment_offer<T0, T1: store + key>(arg0: &mut 0x30414598b5e3e6a5061c86c6c7c162a2197f11961b69bab0a42edb7417ec82ef::atlansui::Platform, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: 0x2::coin::Coin<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x30414598b5e3e6a5061c86c6c7c162a2197f11961b69bab0a42edb7417ec82ef::atlansui::repayment_offer<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    // decompiled from Move bytecode v6
}

